export interface ClientCallbackProvider {
    triggerServerCallback(name: string, cb: (result: any) => void, ...args: any[]): void;
    awaitServerCallback(name: string, ...args: any[]): any;
}

export interface ServerCallbackProvider {
    registerServerCallback(name: string, cb: (playerId: number, ...args: any[]) => any): void;
}
