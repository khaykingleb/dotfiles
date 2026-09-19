# Together API

- Before calling a Together API, require the user to specify whether the target environment is QA or production. Do not infer or default the environment.
- Use variables from only the selected environment. Never mix QA and production credentials or base URLs.
- For QA, use `TOGETHER_QA_BASE_URL` with `TOGETHER_QA_INTERNAL_API_KEY` for internal APIs or `TOGETHER_QA_API_KEY` for public APIs.
- For production, use `TOGETHER_PROD_BASE_URL` with `TOGETHER_PROD_INTERNAL_API_KEY` for internal APIs or `TOGETHER_PROD_API_KEY` for public APIs.
- Never invent, substitute, or hard-code a Together endpoint or credential when the corresponding environment variable is unavailable.
- Never print, log, or otherwise expose credential values. It is safe to check whether a required variable is set.
