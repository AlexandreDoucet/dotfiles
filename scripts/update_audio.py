import subprocess

target_id = ["bluez", "analog-stereo"]

get_command = ["pactl", "list", "short", "sinks"]
set_command = ["pactl", "set-default-sink"]

sinks = {}
for target in target_id:
    sinks.setdefault(target, "")

result = subprocess.run(
    get_command, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE
).stdout.decode("utf-8")

for sink in result.split("\n"):
    for target in target_id:
        if target in sink:
            sinks[target] = sink.split("\t")[1]

default = ""
for target in target_id:
    try:
        sink = sinks[target]
        temp_list = set_command + [sink]
        result = subprocess.run(
            temp_list,
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        ).stdout.decode("utf-8")
        default = sink
        break
    except:
        pass

list_cmd = ["pactl", "list", "short", "sink-inputs"]
update_cmd = ["pactl", "move-sink-input"]

result = (
    subprocess.run(
        list_cmd,
        check=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    .stdout.decode("utf-8")
    .split("\n")
)

for input in result:
    if input == "":
        continue

    id = input.split("\t")[0]
    temp_cmd = update_cmd + [id, default]
    result = (
        subprocess.run(
            temp_cmd,
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )
        .stdout.decode("utf-8")
        .split("\n")
    )
