mongoose = require('mongoose')
Schema = mongoose.Schema

userSchema = new Schema(
  name: {type: String, required: true}
)

module.exports = mongoose.model('users', userSchema)
