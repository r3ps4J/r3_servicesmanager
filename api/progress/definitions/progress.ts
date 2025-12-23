export interface ProgressOptions {
    disable?: {
        movement?: boolean;
        vehicleMovement?: boolean;
        mouse?: boolean;
        combat?: boolean;
    };
    animation?: {
        dict: string;
        clip: string;
    };
    scenario?: string;
    onFinish?: () => void;
    onCancel?: () => void;
}

export interface ClientProgressProvider {
    startProgress(label: string, duration: number, options?: ProgressOptions): void;
    cancelProgress(): void;
}
