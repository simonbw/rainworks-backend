require 'dragonfly/s3_data_store'

Dragonfly.app.configure do
  plugin :imagemagick
  
  datastore :s3,
    bucket_name: ENV['S3_BUCKET'],
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: ENV['AWS_REGION']
end