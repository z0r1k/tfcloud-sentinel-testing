exports.handler = async (event, context, callback) => {
  console.log(`Process env`, JSON.stringify(process.env, null, 2))
  console.log(`Ev`, JSON.stringify(event, null, 2))
  callback(null)
  return context.logStreamName
}
