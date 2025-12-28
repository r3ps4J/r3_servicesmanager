export interface ContextMenuElement {
    title: string;
    description?: string;
    /** Full font awesome 5 icon including prefix such as "fas fa-" */
    icon?: string;
    disabled?: boolean;
    onSelect?: () => void;
}

export interface ContextMenuOptions {
    id: string;
    title: string;
    elements: ContextMenuElement[];
    /** Gets called when the menu is closed by the user or using closeMenu, can be called when an element was selected but this is provider dependent and not always the case */
    onClose?: () => void;
}

export interface ClientContextMenuProvider {
    openMenu(options: ContextMenuOptions): void;
    closeMenu(): void;
}
