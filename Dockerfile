# Use official .NET SDK image for building the project
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy only the project file and restore dependencies
COPY TripPlannerBackend/TripPlannerBackend.csproj ./  
RUN dotnet restore TripPlannerBackend.csproj  

# Copy everything and build the application
COPY TripPlannerBackend/ ./TripPlannerBackend/
WORKDIR /app/TripPlannerBackend
RUN dotnet publish -c Release -o out

# Use official ASP.NET runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/TripPlannerBackend/out .

# Set environment variables
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080

# Run the application
CMD ["dotnet", "TripPlannerBackend.dll"]
