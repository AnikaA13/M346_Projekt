using Amazon.Lambda.Core;
using Amazon.Lambda.S3Events;
using Amazon.S3;
using Amazon.S3.Model;

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

      }
      catch (Exception ex)
      {
        Console.WriteLine(ex.Message);
      }
    }
  }
}