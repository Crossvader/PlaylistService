ActiveModel::Serializer.config.adapter = :json_api

# Transform keys on the client if we must.
ActiveModel::Serializer.config.key_transform = :unaltered
