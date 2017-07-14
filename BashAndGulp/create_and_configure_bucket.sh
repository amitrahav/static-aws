# !/bin/bash

echo "what's your new bucket name?"
read bucketname

echo "bucket region?"
read bucketregion

echo "creating ${bucketname} bucket, on ${bucketregion}"
aws s3api create-bucket --bucket ${bucketname} --region ${bucketregion} --create-bucket-configuration LocationConstraint=${bucketregion}

echo "create policy by bucket name"
sed "s|bucketnameblank|${bucketname}|g" $(pwd)/awss3-policy.conf > $(pwd)/${bucketname}-awss3-policy.conf

echo "setting bucket properties to host static website"
aws s3api put-bucket-website --bucket ${bucketname} --website-configuration file://$(pwd)/${bucketname}-awss3-website.conf
rm $(pwd)/${bucketname}-awss3-policy.conf

echo "attaching bucket policy"
aws s3api put-bucket-policy --bucket ${bucketname} --policy file://$(pwd)/awss3-policy.conf