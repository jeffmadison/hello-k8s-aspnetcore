# build stage
FROM microsoft/dotnet as build-env
WORKDIR /app
COPY ./*.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -o /publish

# runtime image stage
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /publish
COPY --from=build-env /publish/ .
ENTRYPOINT [ "dotnet", "myWebApp.dll" ]
