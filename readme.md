# Static websites Automation with AWS

Some tools for aws automate deploy static websites. every folder should have a different approach for this issue.

## Bush and Gulp
creating and attaching correct policy into S3 bucket, insert deploy task into gulp file.

### Requirements 

* Aws cli - [install](https://github.com/aws/aws-cli) and [configured](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)
* [gulp awspublish](https://www.npmjs.com/package/gulp-awspublish) npm package


### Usage
* create new s3 bucket, attach correct policy and set it as host bucket run:
    ```shell
    $ source ./BashAndGulp/create_and_configure_bucket.sh
    ```
* use your local aws config inside gulp process:
    * run `npm instal --save-dev aws-sdk`
    * require aws-sdk at the begging of your gulp file: `const AWS = require('aws-sdk');`
* install gulp awspublishnpm `npm install --save-dev gulp-awspublish` inside your projects
* create new gulp task named : publish (will copy all files inside dist folder, and one depth subfolder): 
    ```
    gulp.task('publish', () => {
    // create a new publisher using S3 options
    // http://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/S3.html#constructor-property
    const publisher = awspublish.create({
        region: 'eu-west-1',
        params: {
        Bucket: '\\//YOURBUCKETNAME\\'
        },
        credentials: new AWS.SharedIniFileCredentials()
    });

    // define custom headers
    const headers = {
        'Cache-Control': 'max-age=315360000, no-transform, public'
    };

    return (gulp
        .src(["dist/*", "dist/**/*"])
        // gzip, Set Content-Encoding headers and add .gz extension
        .pipe(awspublish.gzip({ ext: '.gz' }))
        // publisher will add Content-Length, Content-Type and headers specified above
        // If not specified it will set x-amz-acl to public-read by default
        .pipe(publisher.publish(headers))
        // sync with local = remove files if not exsisting in local
        .pipe(publisher.sync())
        // create a cache file to speed up consecutive uploads
        .pipe(publisher.cache())
        // print upload updates to console
        .pipe(awspublish.reporter()) );
    });
    ```
* declare gulp process name "deploy":
    ```
    gulp.task('deploy', ['publish'], () => {
    return gulp.src('dist/**/*').pipe($.size({ title: 'build', gzip: true }));
    });
    ```
* inside your project run gulp deploy 
