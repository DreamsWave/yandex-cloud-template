import { FunctionContext, FunctionEvent } from './types';

export const handler = async (event: FunctionEvent, context: FunctionContext) => {
    console.log('hello')
    return ({
        statusCode: 200,
        headers: {
            'Content-Type': 'text/plain',
        },
        body: 'Hello world!',
    })
}
