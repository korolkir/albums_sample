abstract class TestObjects {
  static const validJsonString = '''
        {
          "results": [
            {
              "wrapperType": "undefined",
              "collectionType": "undefined",
              "collectionName": "undefined",
              "artworkUrl100": "",
              "collectionPrice": 0,
              "currency": "USD"
            },
            {
              "wrapperType": "collection",
              "collectionType": "Album",
              "collectionName": "Album1",
              "artworkUrl100": "image1",
              "collectionPrice": 10.99,
              "currency": "USD"
            },
            {
              "wrapperType": "collection",
              "collectionType": "Album",
              "collectionName": "Album2",
              "artworkUrl100": "image2",
              "collectionPrice": 12.99,
              "currency": "USD"
            },
            {
              "wrapperType": "artist",
              "collectionType": "Album",
              "collectionName": "",
              "artworkUrl100": "image3",
              "collectionPrice": 1.99,
              "currency": "USD"
            },
            {
              "wrapperType": "collection",
              "collectionType": "Album3"
            }
          ]
        }
      ''';
}
