import sys
import boto3

emr_client = boto3.client('emr')


def get_duplicated_steps(cluster_id: str) -> list:
    all_steps = get_all_steps(cluster_id)
    return list_duplicates(all_steps)


def get_all_steps(cluster_id: str) -> list:
    names = []
    marker = None
    paged_steps = get_steps(cluster_id, marker)

    while paged_steps != None:
        marker_exist = True if 'Marker' in paged_steps else False
        marker = paged_steps['Marker'] if marker_exist else None
        for item in paged_steps['Steps']:
            names.append(item['Name'])
        paged_steps = get_steps(cluster_id, marker) if marker_exist else None

    return names


def get_steps(cluster_id: str, marker: str = None):
    if marker:
        return emr_client.list_steps(
            ClusterId=cluster_id,
            StepStates=['COMPLETED', 'RUNNING', 'PENDING'],
            Marker=marker
        )
    else:
        return emr_client.list_steps(
            ClusterId=cluster_id,
            StepStates=['COMPLETED', 'RUNNING', 'PENDING']
        )


def list_duplicates(seq: list) -> list:
    seen = set()
    seen_add = seen.add
    seen_twice = set(x for x in seq if x in seen or seen_add(x))
    return list(seen_twice)


if __name__ == '__main__':
    try:
        param_1 = sys.argv[1]
    except IndexError:
        print('You need to inform the Cluster ID!')
        raise SystemExit(1)

    duplicated_steps = get_duplicated_steps(param_1)

    print(f'Total duplicated Steps: {len(duplicated_steps)}')
    print('Names:', ', '.join(duplicated_steps)) if len(duplicated_steps) > 0 else None