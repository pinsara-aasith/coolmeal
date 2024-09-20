from pydantic import BaseModel
from typing import Dict, List

# Memory structure for each session
memory_store: Dict[str, List[str]] = {}

# Initialize custom memory stack (empty at first)
DEFAULT_MEMORY = [
    "'User: Hi ', Assistant: Hi! I am a specialized AI assistant for food data."
]
STACK_SIZE_LIMIT = 20


def format_memory(memory_stack: List[str]) -> str:
    return "\n".join(memory_stack)


def update_memory_stack(
    question: str, response: str, memory_stack: List[str], limit: int = STACK_SIZE_LIMIT
) -> List[str]:
    # Add the new question and response to the stack
    memory_stack.append(f"User: {question}")
    memory_stack.append(f"Assistant: {response}")

    # Ensure the stack doesn't exceed the limit
    if len(memory_stack) > 2 * limit:
        memory_stack = memory_stack[
            -2 * limit :
        ]  # Keep only the last limit interactions

    return memory_stack


def clear_memory_stack() -> List[str]:
    return DEFAULT_MEMORY.copy()
