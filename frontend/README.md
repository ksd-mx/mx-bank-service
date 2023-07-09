# Blockparty Platform


| Module | dev | stg | prd |
| ---- | :--: | :--: | :--: |
|Backend||||
|Marketplace|![badge](https://codebuild.us-east-1.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiMkg0bHhHMTJwT0RLSk1rTlFyUlI2NE9lWXNDUWRVYmI4NGVTVlBwbmdYaDlBeDRya3U3MUdLR3dDMEtCN1FnUEMwZWRmRXpPdnh5T2RDWnNMV1lQaUVRPSIsIml2UGFyYW1ldGVyU3BlYyI6InFUVGJJOG1vdkV6ZlE0L1ciLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=main)|![badge](https://codebuild.us-east-1.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiZUpIbWlSRDB6dEdSRzllOW5XbXpXcEYvOTRpWlZVWis3YmUrWnN5MTVUQzVSR1ZUKzhpV3FmSzVlcG16LzJTZnV6eS9tUVF2b0tJOFRQZVdTeHFmOW9zPSIsIml2UGFyYW1ldGVyU3BlYyI6IllOcTJWT1N2dlh1V2ViWGEiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=staging)|![badge](https://codebuild.us-west-1.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoibk5BVjlzWU4xUlozTjNhYS9Bb1JxTVNBc3pVMFE0Qk5OdWxLS2ovdmQydVdoM3lteEc5c1hKT2tMeFhCZUhQZW5vM3VoZ3ZPSmhYd3ZVUjI3Y0R0WXlRPSIsIml2UGFyYW1ldGVyU3BlYyI6IlBmVnNzNlZRYmVxSCtibFYiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=main)

## Frontend Architecture

- Next.JS
- Storybook 
- NextAuth (Cognito)
- Styled Components + Tailwind CSS (twin.macro)

### Interesting References

* Component Design: https://dev.to/antjanus/the-anatomy-of-my-ideal-react-component-1lo0

## Usefull Commands

- Erase all empty buckets (use with caution)
> aws s3 ls --profile cross-account-profile-name | cut -d" " -f 3 | xargs -I{} aws s3 rb s3://{} --profile cross-account-profile-name