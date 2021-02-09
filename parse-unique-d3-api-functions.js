const fs = require('fs')

const blocksApiData = JSON.parse(
  fs.readFileSync('./data/parsed/blocks-api.json')
)

const d3ApiFunctionSet = new Set()
blocksApiData.map(block => Object.keys(block.api)).forEach(apiList => {
  apiList.forEach(api => {
    d3ApiFunctionSet.add(api)
  })
})

const d3ApiFunctions = Array.from(d3ApiFunctionSet).sort()

try {
  fs.writeFileSync(
    './data/parsed/d3-api-functions.json',
    JSON.stringify(d3ApiFunctions)
  )
  console.log('wrote ./data/parsed/d3-api-functions.json')
} catch (error) {
  console.log(error)
}

try {
  fs.writeFileSync(
    '../blockbuilder-search/metadata/d3-api-functions.json',
    JSON.stringify(d3ApiFunctions)
  )
  console.log('wrote ../blockbuilder-search/metadata/d3-api-functions.json')
} catch (error) {
  console.log(error)
}
