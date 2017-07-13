# Static websites Automation with AWS

Some tools for aws automate deploy static websites. every folder should have a different approach for this issue.

## Bush and Gulp
creating and attaching correct policy into S3 bucket, insert deploy task into gulp file.

### Requirements 

* Aws cli - [install](https://github.com/aws/aws-cli) and [configured](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)
* [gulp awspublish](https://www.npmjs.com/package/gulp-awspublish) npm package


### Usage
to create new s3 bucket, attach correct policy and set it as host bucket run:
```shell
$ source ./BashAndGulp/create_and_configure_bucket.sh
```
