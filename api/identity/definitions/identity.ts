export interface ServerIdentityProvider {
    getPlayerIdentifier(playerId: number): string | undefined;
    getPlayerName(playerId: number): string;
}
