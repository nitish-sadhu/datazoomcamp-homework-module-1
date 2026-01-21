# datazoomcamp-homework-module-1
datazoomcamp module-1 homework

Question 1:
-----------------------------
ANSWER: pip version is "25.3".

Running a docker container from the image python:3.13
        `docker run -it --entrypoint=bash python:3.13`

pip version is 25.3
        `pip --version`

        


Question 2:
-----------------------------
The hostname and port that pgadmin has to use to connect to postgres database is "postgres:5432"/"db:5432".


-----------------------------
downloading the necessary data:

        `wget https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2025-11.parquet`

        `wget https://github.com/DataTalksClub/nyc-tlc-data/releases/download/misc/taxi_zone_lookup.csv`

Preparing the data and inserting into a postgres database:
    Initializing a python venv
        `uv init --python 3.13`

    Adding jupyter to the venv
        `uv add jupyter`

    Running a jupyter notebook
        `uv run jupyter notebook`

    Adding the necessary packages
        `uv add pandas`
        `uv add pyarrow`

- NOTE: To create the postgres database and to query the database using pgadmin, I have used the docker-compose.yaml file provided in the homework. 
        `docker compose up`
        
- The code inserting into the database is in the "ingest_notebook.ipynb"

Question 3:
-----------------------------
- For the trips in November 2025 (lpep_pickup_datetime between '2025-11-01' and '2025-12-01', exclusive of the upper bound), how many trips had a trip_distance of less than or equal to 1 mile?
Answer: trips = 8007

    select count(*) from green_trip_data
    where 
            cast(lpep_pickup_datetime as date) >= '2025-11-01'
        and cast(lpep_pickup_datetime as date) < '2025-12-01'
        and trip_distance <= 1
    ;


Question 4: 
-----------------------------
- Which was the pick up day with the longest trip distance? Only consider trips with trip_distance less than 100 miles (to exclude data errors).
Answer: 2025-11-14

    select cast(lpep_pickup_datetime as date) as pick_up_day, trip_distance from green_trip_data
    where trip_distance < 100
    order by trip_distance desc
    limit 1
    ;




Question 5: 
-----------------------------
- Which was the pickup zone with the largest total_amount (sum of all trips) on November 18th, 2025?
Answer: zone = East Harlem North

    select tzd."Zone", sum(gtd.total_amount) from green_trip_data gtd
    inner join taxi_zones tzd
        on gtd."PULocationID" = tzd."LocationID"
    group by 1
    order by 2 desc
    limit 1
    ;


Question 6: 
-----------------------------
- For the passengers picked up in the zone named "East Harlem North" in November 2025, which was the drop off zone that had the largest tip?
Answer: Zone = Yorkville West

    select "Zone"from taxi_zones
    where "LocationID" = (
        select "DOLocationID" from green_trip_data gtd
        join taxi_zones tzd
            on gtd."PULocationID" = tzd."LocationID"
        where tzd."Zone" = 'East Harlem North'
        group by 1
        order by  max(tip_amount) desc
        limit 1
    )
    ;


Question 7: 
-----------------------------
    terraform init, terraform apply -auto-approve, terraform destroy