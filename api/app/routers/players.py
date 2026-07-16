from fastapi import APIRouter

router = APIRouter()

@router.get("/")
def players():
    return [
        {
            "name": "player1",
            "score": 100,
        },
        {
            "name": "player2",
            "score": 200,
        },
    ]