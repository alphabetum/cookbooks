# for encryption, uncomment use one of the following:
# set[:astrails_safe][:pgp][:password] = "somepass"
# or
# set[:astrails_safe][:pgp][:key] = "some@key"

set[:astrails_safe] = {
  :local => {
    :path => '/var/backups/astrails-safe/:kind/:id'
  }, :keep => {
    :local => 20,
    :s3 => 30
  }
}