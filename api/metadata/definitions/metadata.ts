export interface ServerMetadataProvider {
    getPlayerMetadata(playerId: number, key: string): any | undefined;
    setPlayerMetadata(playerId: number, key: string, value: any): boolean;
}
