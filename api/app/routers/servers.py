from fastapi import APIRouter

router = APIRouter()


@router.get("/")
def servers():
    return [
        {
            "name": "dm",
            "status": "running",
            "port": 27015,
        },
        {
            "name": "3v3",
            "status": "stopped",
            "port": 27016,
        },
        {
            "name": "5v5",
            "status": "stopped",
            "port": 27017,
        },
    ]