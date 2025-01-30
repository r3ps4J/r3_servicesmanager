export interface Job {
    name: string;
    label: string;
    grades: Record<number, JobGrade>;
}

export interface PlayerJob {
    name: string;
    label: string;
    grade: JobGrade & { rank: number };
}

export interface JobGrade {
    name: string;
    label: string;
    salary: number;
    isBoss: boolean;
}

export interface ServerEmploymentProvider {
    getJob(jobName: string): Job | undefined;
    jobExists(jobName: string, jobGrade?: number): boolean;
    getOnlineJobCount(jobName: string): number;
    getPlayerJob(playerId: number): PlayerJob | undefined;
    setPlayerJob(playerId: number, jobName: string, jobGrade: number): boolean;
    playerHasJob(playerId: number, jobName: string): boolean;
}
