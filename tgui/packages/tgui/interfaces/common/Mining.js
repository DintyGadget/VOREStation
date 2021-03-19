import { Fragment } from 'inferno';
import { useBackend } from "../../backend";
import { Box, Button, Input, NoticeBox } from '../../components';

export const MiningUser = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    insertIdText,
  } = props;
  const {
    has_id,
    id,
  } = data;
  return (
    <NoticeBox success={has_id}>
      {has_id ? (
        <Fragment>
          <Box
            display="inline-block"
            verticalAlign="middle"
            style={{
              float: 'left',
            }}>
            Вошел в систему как {id.name}.<br />
            У вас есть {id.points.toLocaleString('en-US')} очков.
          </Box>
          <Button
            icon="eject"
            content="Извлечь ID"
            style={{
              float: 'right',
            }}
            onClick={() => act('logoff')}
          />
          <Box
            style={{
              clear: "both",
            }}
          />
        </Fragment>
      ) : insertIdText}
    </NoticeBox>
  );
};