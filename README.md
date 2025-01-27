# Race Condition in Bash Script

This repository demonstrates a race condition bug in a bash script.  Two processes attempt to increment a counter in the same file concurrently. This can lead to the counter being incremented less frequently than expected due to race conditions.