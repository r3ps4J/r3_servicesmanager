export interface TargetOption {
    label: string;
    name?: string;
    /** Full font awesome 5 icon including prefix such as "fas fa-" */
    icon?: string;
    distance?: number;
    bones?: string[];
    /** Group: minimum grade map */
    groups?: Record<string, number>;
    canInteract?: (entity: number, distance: number, coords: Vector3, name: string, bone: string) => boolean;
    onSelect: (data: TargetResponse) => void;
}

export interface TargetResponse {
    entity: number;
}

export type Vector3 = { x: number; y: number; z: number };

export interface ClientTargetProvider {
    addGlobalObject(options: TargetOption[]): void;
    removeGlobalObject(optionNames: string[]): void;
    addGlobalPlayer(options: TargetOption[]): void;
    removeGlobalPlayer(optionNames: string[]): void;
    addGlobalVehicle(options: TargetOption[]): void;
    removeGlobalVehicle(optionNames: string[]): void;
    addModel(models: number | string | (number | string)[], options: TargetOption[]): void;
    removeModel(models: number | string | (number | string)[], optionNames: string[]): void;
    addEntity(netIds: number | number[], options: TargetOption[]): void;
    removeEntity(netIds: number | number[], optionNames: string[]): void;
    addLocalEntity(entities: number | number[], options: TargetOption[]): void;
    removeLocalEntity(entities: number | number[], optionNames: string[]): void;
    addSphereZone(parameters: {
        name: string;
        options: TargetOption[];
        coords: Vector3;
        radius?: number;
        debug?: boolean;
    }): string;
    addBoxZone(parameters: {
        name: string;
        options: TargetOption[];
        coords: Vector3;
        size?: Vector3;
        debug?: boolean;
    }): string;
    addPolyZone(parameters: {
        name: string;
        options: TargetOption[];
        points: Vector3[];
        thickness?: Vector3;
        debug?: boolean;
    }): string;
    removeZone(name: string): void;
}
