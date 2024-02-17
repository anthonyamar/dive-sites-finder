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

    const search = instantsearch({
      searchClient,
      indexName: 'GeoGroup',
      insight: true,
    });

    search.addWidgets([
      instantsearch.widgets.searchBox({
        container: '#searchbox',
        autofocus: true,
        showReset: true,
        placeholder: "Search for continents, seas, countries, regions, cities, dive sites or centers..."
      }),
      
      instantsearch.widgets.poweredBy({
        container: '#searchbox',
      }),
      
      instantsearch.widgets.hits({
        container: '#hits',
        templates: {
          empty({ query }, { html }) {
              return html`<div>
                <p>No results have been found for ${query}}</p>
                <a role="button" href=".">Reset all filters</a>
              </div>`;
          },
          item(hit, { html, components }) {
            return html`
              <h2>
                ${components.Highlight({ attribute: 'name', hit })}
              </h2>
              <p class="mx-10"><i>${hit.description.substring(0, 40)}...</i></p>
            `;
          },
          
        },
      })
    ]);

    search.start();
    
  }
}
