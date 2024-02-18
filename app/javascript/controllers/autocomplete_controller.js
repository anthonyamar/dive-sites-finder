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
      autoFocus: true,
      renderNoResults({ state, render, html }, root) {
        render(html`<a href="/geo_groups"><div class="aa-NoResults">No results for "${state.query}". Search by destinations 🌎  → </div></a>`, root);
      },
      getSources: ({ query }) => this.getSources(query, searchClient),
    });
    
  } // end connect()
  
  getSources(query, searchClient) {
    const createSource = (indexName, headerTitle) => {
      return {
        sourceId: indexName,
        getItemInputValue: ({ item }) => item.name,
        getItems: () => {
          return searchClient
            .initIndex(indexName)
            .search(query, {
              hitsPerPage: 2,
             })
            .then((res) => {
              return res.hits.map((hit) => ({
                ...hit, 
                name: hit.name,
                kind: hit.l_kind,
                geo_refs: hit.l_geo_refs,
                path: hit.full_path,
              }));
            });
        },
        templates: {
          header() {
            return headerTitle;
          },
          item({ item, html }) {
            return html`
            <a href="${item.path}" alt="${item.name}">
              <div class="px-3 py-1">
                <div class="font-serif text-dark-blue text-xl">${item.name}</div>
                <div class="text-main-sky text-sm">
                  ${item.geo_refs == null ? item.kind : item.geo_refs}
                </div>
              </div>
            </a>`;
          },
        },
      };
    };

    return [
      createSource('Country', 'Countries...'),
      createSource('City', 'Cities...'),
      createSource('GeoGroup', 'Continents, seas and oceans...'),
      createSource('Region', 'Regions...'),
    ];
  }

  disconnect() {
    if (this.autocompleteInstance) {
      this.autocompleteInstance.destroy();
      this.autocompleteInstance = null;
    }
  }
}
