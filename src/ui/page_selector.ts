import {Pagination} from "#data/pagination.js";
import {html, type TemplateResult} from "lit";
import {customElement, property} from "lit/decorators.js";
import {classMap} from "lit/directives/class-map.js";
import {when} from "lit/directives/when.js";
import {Component} from "./component.js";

/**
 * An event dispatched when a navigation has been requested.
 */
export class PageSelectorEvent extends Event {

	/**
	 * The event type.
	 */
	static readonly type = "pageSelector:navigate";

	/**
	 * The page to be navigated to.
	 */
	readonly page: number;

	/**
	 * Creates a new pager event.
	 * @param page The page to be navigated to.
	 */
	constructor(page: number) {
		super(PageSelectorEvent.type);
		this.page = page;
	}
}

/**
 * Displays links relevant to the pagination of data items.
 */
@customElement("page-selector")
export class PageSelector extends Component {

	/**
	 * The pager alignment.
	 */
	@property() alignment: "start"|"center"|"end" = "center";

	/**
	 * The underlying pagination model.
	 */
	@property({attribute: false}) pagination = new Pagination;

	/**
	 * The number of items displayed around the active item.
	 */
	@property({type: Number}) sideItems = 1;

	/**
	 * The list of buttons to display.
	 */
	get #items(): number[] {
		const start = Math.max(1, this.pagination.page - this.sideItems);
		const end = Math.min(this.pagination.pageCount, this.pagination.page + this.sideItems);

		const items = [];
		if (start > 1) items.push(1);
		if (start > 2) items.push(0);
		for (let index = start; index <= end; index++) items.push(index);
		if (end < this.pagination.pageCount - 1) items.push(0);
		if (end < this.pagination.pageCount) items.push(this.pagination.pageCount);
		return items;
	}

	/**
	 * Navigates to the specified page.
	 * @param page The page to be navigated to.
	 * @param event The dispatched event.
	 */
	navigate(page: number, event?: Event): void {
		if (event) (event.target as Element).closest("button")?.blur();
		if (page >= 1 && page <= this.pagination.pageCount && page != this.pagination.page) this.dispatchEvent(new PageSelectorEvent(page));
	}

	/**
	 * Renders this component.
	 * @returns The view template.
	 */
	protected override render(): TemplateResult {
		return when(this.pagination.pageCount > 1, () => html`
			<nav>
				<ul class="pagination justify-content-${this.alignment}">
					<li class="page-item ${classMap({disabled: this.pagination.page <= 1})}">
						<button class="page-link" @click=${(event: Event) => this.navigate(this.pagination.page - 1, event)}>
							<i class="icon">chevron_left</i><span class="d-none d-sm-inline ms-1">Précédent</span>
						</button>
					</li>
					${this.#items.map(index => html`
						<li class="page-item ${classMap({active: index == this.pagination.page, disabled: !index})}">
							<button class="page-link" @click=${(event: Event) => this.navigate(index, event)}>
								${index ? index : "..."}
							</button>
						</li>
					`)}
					<li class="page-item ${classMap({disabled: this.pagination.page >= this.pagination.pageCount})}">
						<button class="page-link" @click=${(event: Event) => this.navigate(this.pagination.page + 1, event)}>
							<span class="d-none d-sm-inline me-1">Suivant</span><i class="icon">chevron_right</i>
						</button>
					</li>
				</ul>
			</nav>
		`);
	}
}
