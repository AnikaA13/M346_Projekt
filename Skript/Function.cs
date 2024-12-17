using Amazon.Lambda.Core;
using Amazon.Lambda.S3Events;
using Amazon.S3;
using Amazon.S3.Model;
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
        Console.WriteLine("kein S3 gefunden");

      string inputBucket = "input-bucket346";
      string outputBucket = "output-bucket346";
      string objKey = record.Object.Key;

      try
      {
        GetObjectResponse response = await S3Client.GetObjectAsync(inputBucket, objKey);

        using Stream responseStream = response.ResponseStream;

        //usefinde wie i csv zu json mache chan

        var lines = File.ReadAllLines(@"C:\file.txt");

        var headers = lines[0].Split(',');
        var json = new List<Dictionary<string, string>>();
        for (int i = 1; i < lines.Length; i++)
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
        var finishedJson =  JsonSerializer.Serialize(json, options);
      }
      catch (Exception ex)
      {
        Console.WriteLine(ex.Message);
      }
    }
  }
}