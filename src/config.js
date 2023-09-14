var conf = {
      name: 'index',
      jsonApi: '/__autoindex__/',

      visibilityOptions: {
          size: {
              use: true,
              type: 'readable' //raw, readable, both
          },
          date: {
              use: true,
              type: 'moment' //raw, moment, both
          }
      }
};
