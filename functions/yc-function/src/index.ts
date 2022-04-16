import { FunctionContext, FunctionEvent } from './types';

export const handler = async (event: FunctionEvent, context: FunctionContext) => {
    console.log(JSON.stringify(event))
    let body = {}
    if (event.body !== null && event.body !== undefined) {
        try {
            body = JSON.parse(event.body);
        }
        catch (error) {
            body = event.body;
        }
    }
    // DO STUFF...



    return {
        statusCode: 200,
        headers: {
            'Content-Type': 'text/plain',
        },
        body: 'Hello world!'
    }
};
