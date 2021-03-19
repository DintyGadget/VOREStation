import { useBackend } from '../../backend';
import { Fragment } from 'inferno';
import { Box, Section, LabeledList, Button, AnimatedNumber, ProgressBar } from '../../components';

export const PortableBasicInfo = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    connected,
    holding,
    on,
    pressure,
    powerDraw,
    cellCharge,
    cellMaxCharge,
  } = data;

  return (
    <Fragment>
      <Section
        title="Состояние"
        buttons={(
          <Button
            icon={on ? 'power-off' : 'times'}
            content={on ? 'Вкл' : 'Выкл'}
            selected={on}
            onClick={() => act('power')} />
        )}>
        <LabeledList>
          <LabeledList.Item label="Давление">
            <AnimatedNumber value={pressure} />
            {' kPa'}
          </LabeledList.Item>
          <LabeledList.Item
            label="Порт"
            color={connected ? 'good' : 'average'}>
            {connected ? 'Подключен' : 'Не подключен'}
          </LabeledList.Item>
          <LabeledList.Item label="Загруженность">
            {powerDraw} W
          </LabeledList.Item>
          <LabeledList.Item label="Заряд">
            <ProgressBar
              value={cellCharge}
              minValue={0}
              maxValue={cellMaxCharge}
              ranges={{
                good: [cellMaxCharge * 0.5, Infinity],
                average: [cellMaxCharge * 0.25, cellMaxCharge * 0.5],
                bad: [-Infinity, cellMaxCharge * 0.25],
              }} >
              {cellCharge} W
            </ProgressBar>
          </LabeledList.Item>
        </LabeledList>
      </Section>
      <Section
        title="Емкость"
        minHeight="82px"
        buttons={(
          <Button
            icon="eject"
            content="Извлечь"
            disabled={!holding}
            onClick={() => act('eject')} />
        )}>
        {holding ? (
          <LabeledList>
            <LabeledList.Item label="Этикетка">
              {holding.name}
            </LabeledList.Item>
            <LabeledList.Item label="Давление">
              <AnimatedNumber
                value={holding.pressure} />
              {' kPa'}
            </LabeledList.Item>
          </LabeledList>
        ) : (
          <Box color="average">
            Емкость не обнаружена
          </Box>
        )}
      </Section>
    </Fragment>
  );
};
