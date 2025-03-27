import asyncio
import warnings
import subprocess

# ✅ Suppress deprecation warnings
warnings.filterwarnings("ignore", category=DeprecationWarning)

# ✅ Monkey-patch asyncio.wait globally
async def safe_wait(awaitables, *args, **kwargs):
    tasks = [asyncio.create_task(coro) for coro in awaitables if asyncio.iscoroutine(coro)]
    tasks += [coro for coro in awaitables if not asyncio.iscoroutine(coro)]
    return await asyncio.wait(tasks, *args, **kwargs)

# Override asyncio.wait globally
asyncio.wait = safe_wait

# ✅ Run Rasa with patched asyncio.wait
subprocess.run(["rasa", "run", "--enable-api"])
