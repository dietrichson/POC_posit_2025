export class WebRError extends Error {
    constructor(message) {
        super(message);
        this.name = 'WebRError';
    }
}

export class WebRWorkerError extends WebRError {
    constructor(message) {
        super(message);
        this.name = 'WebRWorkerError';
    }
}

export class WebRChannelError extends WebRError {
    constructor(message) {
        super(message);
        this.name = 'WebRChannelError';
    }
}

export class WebRPayloadError extends WebRError {
    constructor(message) {
        super(message);
        this.name = 'WebRPayloadError';
    }
}