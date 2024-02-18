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
    
    if (this.autocompleteInstance) {
      return;
    }
    
    this.autocompleteInstance = autocomplete({
      container: '#autocomplete',
      placeholder: 'Search for continents, seas, countries, regions, cities, dive sites or centers...',
      openOnFocus: true,
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
                      kind: hit.l_kind,
                      path: hit.full_path,
                    };
                  });
                });
            },
            templates: {
              header() {
                return 'Continents, seas and oceans...';
              },
              item({ item, html }) {
                return html`
                <a href="${item.path}" alt="${item.name}">
                  <div class="flex justify-between p-3">
                    <div class="font-serif text-dark-blue text-xl">${item.name}</div>
                    <div class="text-main-sky text-xl">${item.kind}</div>
                  </div>
                </a>`;
              },
              noResults() {
                return 'No results for this query.';
              }, 
            },
          },
          {
            sourceId: 'country',
            getItemInputValue: ({ item }) => item.name,
            getItems: ({ query }) => {
              return searchClient
                .initIndex('Country')
                .search(query)
                .then((res) => {
                  return res.hits.map((hit) => {
                    return { 
                      ...hit, 
                      name: hit.name,
                      kind: hit.l_kind,
                      path: hit.full_path,
                    };
                  });
                });
            },
            templates: {
              header() {
                return 'Countries...';
              },
              item({ item, html }) {
                return html`
                <a href="${item.path}" alt="${item.name}">
                  <div class="flex justify-between p-3">
                    <div class="font-serif text-dark-blue text-xl">${item.name}</div>
                    <div class="text-main-sky text-xl">${item.kind}</div>
                  </div>
                </a>`
              },
              noResults() {
                return 'No results for this query.';
              }, 
            },
          },
        ];
      },
    });
    
  } // end connect()

  disconnect() {
    if (this.autocompleteInstance) {
      this.autocompleteInstance.destroy();
      this.autocompleteInstance = null;
    }
  }
}
