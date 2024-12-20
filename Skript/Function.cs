using Amazon.Lambda.Core;
using Amazon.Lambda.S3Events;
using Amazon.S3;
using Amazon.S3.Model;
using System.Text;
using System.Text.Json;

namespace M346
{
  public class Function
  {
    private static readonly IAmazonS3 S3Client = new AmazonS3Client();

    public async Task FileInContainer(S3Event s3Event, ILambdaContext context)
    {
      var record = s3Event.Records?[0].S3;

      if (record == null)
      {
        Console.WriteLine("kein S3 gefunden");
        return;
      }

      string inputBucket = Environment.GetEnvironmentVariable("INPUT_BUCKET");
      string outputBucket = Environment.GetEnvironmentVariable("OUTPUT_BUCKET");
      string objKey = record.Object.Key;

      try
      {
        GetObjectResponse response = await S3Client.GetObjectAsync(inputBucket, objKey);

        using Stream responseStream = response.ResponseStream;
        using var reader = new StreamReader(responseStream);
        
        var lines = new List<string>();

        while (!reader.EndOfStream)
          lines.Add(await reader.ReadLineAsync());

        var headers = lines[0].Split(',');
        var json = new List<Dictionary<string, string>>();
        for (int i = 1; i < lines.Count; i++)
        {
          var values = lines[i].Split(',');
          var obj = new Dictionary<string, string>();

          for (int j = 0; j < headers.Length; j++)
          {
            obj[headers[j]] = values[j];
          }
          json.Add(obj);
        }
        var options = new JsonSerializerOptions { WriteIndented = true };
        string? finishedJson = null;
        if (json.Count > 0)
          finishedJson = JsonSerializer.Serialize(json, options);

        using var outputStream = new MemoryStream(Encoding.UTF8.GetBytes(finishedJson));
        var putRequest = new PutObjectRequest
        {
          BucketName = outputBucket,
          Key = $"{objKey}.json",
          InputStream = outputStream,
          ContentType = "application/json"
        };

        await S3Client.PutObjectAsync(putRequest);
      }
      catch (Exception ex)
      {
        Console.WriteLine(ex.Message);
      }
    }
  }
}
