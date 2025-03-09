import { IPointerEventsAdapter, IPointerEventsAdapterHandler } from "./typings"
import { invokeHandler } from "./utils"

let handlerRef: DotNet.DotNetObject

async function addForHandlerAsync(handlerReference: DotNet.DotNetObject) {
    handlerRef = handlerReference
    window.addEventListener("click", (ev) =>
        invokeHandler<IPointerEventsAdapterHandler>(
            handlerRef,
            "handleClickAtAsync",
            ev.x,
            ev.y
        )
    )
}

export default { addForHandlerAsync } as IPointerEventsAdapter
