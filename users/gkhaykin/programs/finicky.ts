// @ts-ignore Finicky provides its type declarations after installation.
import type { FinickyConfig } from "/Applications/Finicky.app/Contents/Resources/finicky.d.ts";

export default {
  defaultBrowser: "Google Chrome",
  handlers: [
    {
      match: [
        "together.ai*",
        "*.together.ai*",
        "together-ai.okta.com*",
        "*.awsapps.com*",
        "oidc.*.amazonaws.com*",
        "github.com/togethercomputer*",
        "github.com/orgs/togethercomputer*",
      ],
      browser: {
        name: "Google Chrome",
        profile: "Together",
      },
    },
  ],
} satisfies FinickyConfig;
