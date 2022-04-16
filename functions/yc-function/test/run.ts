import { handler } from '../src/index'
import { FunctionEvent, FunctionContext } from '../src/types'
import post from '../../../mock/post_example.json'

const event: FunctionEvent = post;
const context: FunctionContext = {};

(async function () {
    await handler(event, context);
})()