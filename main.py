# main.py
from molad import Molad, MetonicScheduler
from julius_time_kernel import TimeKernel, JuliusEngine, DaatShellError

def run_system():
    # 1. Initialize Kernel & Engine
    kernel = TimeKernel()
    engine = JuliusEngine(kernel)

    print("--- STARTING KERNEL CYCLE ---")

    print("\n--- STEP 1: UNAUTHORIZED REASONING ---")
    try:
        print("Attempting to reason without temporal anchor...")
        engine.process(100.0)
    except DaatShellError as e:
        print(f"❌ Blocked by Kernel: {e}")

    print("\n--- STEP 2: KICKSTARTING THE CYCLE ---")
    # 2. Start at Epoch (t0)
    # Using the values from the specification: day=2, hour=5, part=204
    initial_molad = Molad(day=2, hour=5, part=204)
    kernel.sanctify(initial_molad)
    scheduler = MetonicScheduler(initial_molad)

    print("\n--- STEP 3: SANCTIFIED REASONING ---")
    result = engine.process(100.0)
    print(f"✅ Reasoning result: {result}")

    # 3. Running a 12-month sequence (Year 1 of Metonic Cycle)
    print("\n--- STEP 4: 12-MONTH SEQUENCE ---")
    for month in range(1, 13):
        current_m = scheduler.step()
        kernel.sanctify(current_m)

        print(f"Month {month}:")
        engine.process(100.0)

    print("\n--- CYCLE COMPLETE ---")

if __name__ == "__main__":
    run_system()
