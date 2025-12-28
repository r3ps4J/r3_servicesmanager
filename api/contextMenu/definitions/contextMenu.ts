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
    onClose?: () => void;
}

export interface ClientContextMenuProvider {
    openMenu(options: ContextMenuOptions): void;
    closeMenu(): void;
}
