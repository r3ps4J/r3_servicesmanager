export interface ClientStateProvider {
    isPlayerLoaded(): boolean;
    onPlayerLoaded(callback: () => void): { unsubscribe: () => void };
}
