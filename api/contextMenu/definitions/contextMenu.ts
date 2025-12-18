export interface MenuElement {
    title: string;
    description?: string;
    /** Full font awesome 5 icon including prefix such as "fas fa-" */
    icon?: string;
    disabled?: boolean;
    onSelect?: () => void;
}

export interface MenuOptions {
    id: string;
    title: string;
    elements: MenuElement[];
}

export interface ClientContextMenuProvider {
    openMenu(options: MenuOptions): void;
    closeMenu(): void;
}
