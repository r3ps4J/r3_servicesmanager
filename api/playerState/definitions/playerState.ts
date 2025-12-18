export interface ClientPlayerStateProvider {
    isPlayerLoaded(): boolean;
    onPlayerLoaded(callback: () => void): { unsubscribe: () => void };
}
