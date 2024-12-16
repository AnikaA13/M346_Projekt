using Amazon.Lambda.Core;
using Amazon.Lambda.S3Events;
using Amazon.S3;

namespace M346
{
  public class Function
  {
    private static readonly IAmazonS3 S3Client = new AmazonS3Client();

    public async Task FileInContainer(S3Event sender, ILambdaContext e)
    {
      string inputBucket = "input-bucket346";
      string outputBucket = "output-bucket346";


    }
  }
}