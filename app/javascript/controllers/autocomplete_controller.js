import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  static targets = [
    "algoliaAppId", 
    "algoliaSearchKey",
  ]

  static values = {
    algoliaAppId: String,
    algoliaSearchKey: String,
  }

  connect() {
    const searchClient = algoliasearch(
      this.data.get("algoliaAppId"), 
      this.data.get("algoliaSearchKey")
    );
    
    console.log(searchClient);
    
    autocomplete({
      container: '#autocomplete',
      placeholder: 'Search for continents, seas, countries, regions, cities, dive sites or centers...',
      getSources({ query }) {
        return [
          {
            sourceId: 'geoGroup',
            getItemInputValue: ({ item }) => item.name,
            getItems: ({ query }) => {
              return searchClient
                .initIndex('GeoGroup')
                .search(query)
                .then((res) => {
                  return res.hits.map((hit) => {
                    return { 
                      ...hit, 
                      name: hit.name,
                      kind: hit.kind,
                    };
                  });
                });
            },
            templates: {
              item({ item, html }) {
                return html`<div class="flex justify-between p-3">
                  <div class="font-serif text-dark-blue text-xl">${item.name}</div>
                  <div class="text-main-sky text-xl">${item.kind}</div>
                </div>`;
              },
              noResults() {
                return 'No results for this query.';
              }, 
            },
          },
        ];
      },
    });
    
  }
}
