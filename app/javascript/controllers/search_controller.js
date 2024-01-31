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
    console.log(this.data.get("algoliaAppId"))
    console.log(this.data.get("algoliaSearchKey"))

    const searchClient = algoliasearch(this.data.get("algoliaAppId"), this.data.get("algoliaSearchKey"));

    const search = instantsearch({
      indexName: 'GeoGroup',
      searchClient,
    });

    search.addWidgets([
      instantsearch.widgets.searchBox({
        container: '#searchbox',
      }),

      instantsearch.widgets.hits({
        container: '#hits',
        templates: {
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
