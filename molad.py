# molad.py
PARTS_PER_HOUR = 1080
HOURS_PER_DAY = 24
# Average lunar month length: 29 days, 12 hours, 793 parts
LUNAR_MONTH_PARTS = (29 * HOURS_PER_DAY * PARTS_PER_HOUR) + (12 * PARTS_PER_HOUR) + 793

class Molad:
    def __init__(self, day: int, hour: int, part: int):
        self.day = day % 7
        self.hour = hour
        self.part = part

    def total_parts(self) -> int:
        return (self.day * HOURS_PER_DAY * PARTS_PER_HOUR) + (self.hour * PARTS_PER_HOUR) + self.part

    def str(self) -> str:
        return f"D:{self.day} H:{self.hour} P:{self.part}"

class MetonicScheduler:
    def __init__(self, initial_molad: Molad):
        self.current_parts = initial_molad.total_parts()

    def step(self):
        """Advances the system to the next month"""
        self.current_parts += LUNAR_MONTH_PARTS

        days, rem = divmod(self.current_parts, HOURS_PER_DAY * PARTS_PER_HOUR)
        hours, parts = divmod(rem, PARTS_PER_HOUR)
        return Molad(days % 7, hours, parts)
