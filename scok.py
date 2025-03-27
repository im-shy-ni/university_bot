import asyncio
import tracemalloc
from sanic import Sanic
from sanic.response import json
import socketio

# Start tracemalloc for debugging memory issues
tracemalloc.start()

app = Sanic("MyApp")

# Correct Sanic-SocketIO integration
sio = socketio.AsyncServer(async_mode='sanic')
sio.attach(app)

# Async coroutines
async def example_coroutine_1():
    await asyncio.sleep(1)
    print("Example Coroutine 1 done")

async def example_coroutine_2():
    await asyncio.sleep(2)
    print("Example Coroutine 2 done")

@app.route("/")
async def test(request):
    # Use asyncio.wait without create_task
    done, pending = await asyncio.wait([
        example_coroutine_1(),
        example_coroutine_2()
    ])
    
    # Display memory usage statistics for debugging
    snapshot = tracemalloc.take_snapshot()
    top_stats = snapshot.statistics('lineno')

    print("[ TOP 10 MEMORY USAGE ]")
    for stat in top_stats[:10]:
        print(stat)

    return json({"status": "done"})

# SocketIO event handler
@sio.event
async def connect(sid, environ):
    print(f"Client connected: {sid}")
    await sio.enter_room(sid, data["session_id"])

    print(f"Client {sid} entered room")

@app.before_server_start
async def before_server_start(app, loop):
    print("Starting server...")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
