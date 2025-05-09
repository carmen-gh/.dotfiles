return {
    yaml = {
      schemaStore = {
        enable = false, -- this plugin and its advanced options like `ignore`.
        url = "", -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
      },
      schemas = require("schemastore").yaml.schemas(),
    },
}
