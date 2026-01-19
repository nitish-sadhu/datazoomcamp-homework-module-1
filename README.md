# datazoomcamp-homework-module-1
datazoomcamp module-1 homework

Question 1:
-----------------------------
Running a docker container from the image python:3.13
        `docker run -it --entrypoint=bash python:3.13`

pip version is 25.3
        `pip --version`


***Question 2:
-----------------------------
The hostname and port that pgadmin has to use to connect to postgres database is db:5432


-----------------------------
uv init --python 3.13
uv add jupyter
uv run jupyter notebook
uv add pandas
uv add pyarrow

Question 3:
-----------------------------

trips = 8007

    select count(*) from green_trip_data
    where 
            cast(lpep_pickup_datetime as date) >= '2025-11-01'
        and cast(lpep_pickup_datetime as date) < '2025-12-01'
        and trip_distance <= 1
    ;


Question 4: 
-----------------------------
    select cast(lpep_pickup_datetime as date) as pick_up_day, trip_distance from green_trip_data
    where trip_distance < 100
    order by trip_distance desc
    limit 1
    ;

Day with longest trip distance is 2025-11-14


Question 5: 
-----------------------------
zone: East Harlem North

    select tzd."Zone", sum(gtd.total_amount) from green_trip_data gtd
    inner join taxi_zones tzd
        on gtd."PULocationID" = tzd."LocationID"
    group by 1
    order by 2 desc
    limit 1
    ;


Question 6: 
-----------------------------
Zone = Yorkville West

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